import { Injectable } from '@angular/core';
import {BehaviorSubject, Observable, Subject} from "rxjs";
import {Thread} from "../model/thread.model";
import {MessageService} from "./message.service";
import {combineLatest, map} from "rxjs/operators";
import {Message} from "../model/message.model";
import * as _ from 'underscore'

@Injectable()
export class ThreadService {

    // 这个流发出一个映射, 将Thread的id作为string键, Thread本身作为值
    threads: Observable<{ [key: string]: Thread }>;

    orderedThreads: Observable<Thread[]>;

    currentThread: Subject<Thread> = new BehaviorSubject<Thread>(new Thread());

    currentThreadMessages: Observable<Message[]>;

    constructor(private messageService: MessageService) {
        this.threads = messageService.messages
            .pipe(
                map((messages: Message[]) => {
                    let threads: { [key: string]: Thread } = {};
                    // Store the message's thread in our accumulator `threads`
                    messages.map((message: Message) => {
                        threads[message.thread.id] = threads[message.thread.id] || message.thread;

                        let messagesThread: Thread = threads[message.thread.id];
                        if (!messagesThread.lastMessage || messagesThread.lastMessage.sentAt < message.sentAt) {
                            messagesThread.lastMessage = message;
                        }
                    });
                    return threads;
                })
            );

        this.orderedThreads = this.threads
            .pipe(
                map((threadGroups: { [key: string]: Thread }) => {
                    let threads: Thread[] = _.values(threadGroups);
                    return _.sortBy(threads, (t: Thread) => t.lastMessage.sentAt).reverse();
                })
            );

        this.currentThreadMessages = this.currentThread
            .pipe(
                combineLatest(messageService.messages, (currentThread: Thread, messages: Message[]) => {
                    if (currentThread && messages.length > 0) {
                        return _.chain(messages)
                            .filter((message: Message) => (message.thread.id === currentThread.id))
                            .map((message: Message) => {
                                message.isRead = true;
                                return message;
                            }).value();
                    } else {
                        return [];
                    }
                })
            );

        this.currentThread.subscribe(this.messageService.markThreadAsRead);
    }

    setCurrentThread(newThread: Thread): void {
        this.currentThread.next(newThread);
    }
}

export  var threadsServiceInjectables: Array<any> = [
    ThreadService
];
