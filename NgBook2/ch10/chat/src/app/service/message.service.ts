import {Injectable} from '@angular/core';
import {Observable, Subject} from "rxjs";
import {filter, map, publishReplay, refCount, scan} from "rxjs/operators";
import {Message} from "../model/message.model";
import {Thread} from "../model/thread.model";
import {User} from "../model/user.model";

let initialMessages: Message[] = [];
interface IMessagesOperation extends Function{
    (messages: Message[]): Message[];
}

@Injectable()
export class MessageService {
    newMessages: Subject<Message> = new Subject<Message>();
    messages: Observable<Message[]>;
    /**
     * 用来接收操作
     */
    updates: Subject<any> = new Subject<any>();

    create: Subject<Message> = new Subject<Message>();

    markThreadAsRead: Subject<any> = new Subject<any>();
    /**
     * 这个实现echo 回声时有用
     * @param message
     */
    addMessage(message: Message): void {
        this.newMessages.next(message);
    }

    /**
     * 要一个不包含User的消息流
     * @param thread
     * @param user
     */
    messagesForThreadUser(thread: Thread, user: User): Observable<Message> {
        return this.newMessages
            .pipe(
                filter((message: Message) => {
                    /**
                     * belong this thread, && , author id != user id
                     */
                    return (message.thread.id === thread.id) && (message.author.id !== user.id);
                })
            )
    }
    constructor() {
        this.messages = this.updates
            .pipe(
                /**
                 * 把每个中间过程中计算出结果发送出去, 他不会等到全部完成再发送
                 * 1. 经过累加的messages流
                 * 2. 将要应用的新Operation
                 * 3. 返回新的message[]
                 */
                scan((messages: Message[],
                    operation: IMessagesOperation) => {
                    return operation(messages);
                }, initialMessages),
                    publishReplay(1),
                    refCount()
            );

        this.create
            .pipe(
                map(function (message: Message): IMessagesOperation {
                    return (messages: Message[]) => {
                        return messages.concat(message);
                    }
                })
            )
            .subscribe(this.updates);
        this.newMessages
            .subscribe(this.create);

        this.markThreadAsRead
            .pipe(
                map((thread: Thread) => {
                    return (messages: Message[]) => {
                        return messages.map((message: Message) => {
                            if (message.thread.id === thread.id) {
                                message.isRead = true;
                            }
                            return message;
                        })
                    }
                })
            )
            .subscribe(this.updates)
    }
}

export var messagesServiceInjectables: Array<any> = [
    MessageService
];